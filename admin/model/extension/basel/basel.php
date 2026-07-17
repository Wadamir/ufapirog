<?php
class ModelExtensionBaselBasel extends Model
{

    public function getSettingValue($key, $store_id = 0)
    {
        $query = $this->db->query("SELECT * FROM " . DB_PREFIX . "setting WHERE store_id = '" . (int)$store_id . "' AND `key` = '" . $this->db->escape($key) . "'");

        if ($query->num_rows) {
            $result = $query->row;

            if (!empty($result['serialized'])) {
                $result['value'] = json_decode($result['value'], true);
            }

            return $result['value'];
        } else {
            return null;
        }
    }

    public function addSettingValue($code, $key, $value, $store_id = 0)
    {
        $this->db->query("INSERT INTO " . DB_PREFIX . "setting SET "
            . "store_id = '" . (int) $store_id . "', "
            . "`code` = '" . $this->db->escape($code) . "', "
            . "`key` = '" . $this->db->escape($key) . "', "
            . "`value` = '" . $this->db->escape($value) . "'");
    }

    public function updateContactSetting($config_key, $langdata_key, $value, $store_id = 0)
    {
        // Update main config setting
        $existing_value = $this->getSettingValue($config_key, $store_id);

        if (!is_null($existing_value)) {
            // Update existing
            $this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape($value) . "', serialized = '0' "
                . "WHERE `code` = 'config' AND `key` = '" . $this->db->escape($config_key) . "' AND store_id = '" . (int)$store_id . "'");
        } else {
            // Insert new
            $this->addSettingValue('config', $config_key, $value, $store_id);
        }

        // Update config_langdata JSON for all languages
        $this->updateLangData($langdata_key, $value, $store_id);
    }

    private function updateLangData($langdata_key, $value, $store_id = 0)
    {
        // Get current config_langdata
        $langdata = $this->getSettingValue('config_langdata', $store_id);

        if (!is_array($langdata)) {
            $langdata = array();
        }

        // Get all languages
        $this->load->model('localisation/language');
        $languages = $this->model_localisation_language->getLanguages();

        // Update the value for all languages, preserving all other data
        foreach ($languages as $language) {
            $lang_id = $language['language_id'];

            // Ensure language entry exists
            if (!isset($langdata[$lang_id])) {
                $langdata[$lang_id] = array();
            }

            // Update only the specific key, preserve all other keys
            $langdata[$lang_id][$langdata_key] = $value;
        }

        // Save updated config_langdata with all preserved data
        $this->db->query("UPDATE " . DB_PREFIX . "setting SET `value` = '" . $this->db->escape(json_encode($langdata)) . "', serialized = '1' "
            . "WHERE `code` = 'config' AND `key` = 'config_langdata' AND store_id = '" . (int)$store_id . "'");
    }

    public function getConfigWithLangFallback($key)
    {
        // Сначала пробуем получить значение из основного конфига
        $value = $this->config->get($key);

        // Если значение пусто, пробуем получить из config_langdata
        if (empty($value)) {
            // Маппинг ключей конфига на поля в config_langdata
            $langdata_fields = array(
                'config_address' => 'address',
                'config_open' => 'open',
                'config_telephone' => 'phone',
                'config_email' => 'email'
            );

            if (isset($langdata_fields[$key])) {
                $field = $langdata_fields[$key];
                $language_id = (int)$this->config->get('config_language_id');

                $query = $this->db->query(
                    "SELECT " . $field . " FROM " . DB_PREFIX . "config_langdata 
                    WHERE language_id = " . $language_id . " 
                    LIMIT 1"
                );

                if ($query->num_rows) {
                    $value = $query->row[$field];
                }
            }
        }

        return $value;
    }
}
