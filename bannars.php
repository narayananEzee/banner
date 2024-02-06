<?php
class Config extends MY_Controller{
public function adminbanner() {
        
        $this->is_logged_in();

        $api_url = 'https://vertex.ezeeinfo.in/api/namespace';
        $response = file_get_contents($api_url);
        $data = json_decode($response, true);
        $vertexdata = $data['data'];

        $url1 = '';
        $url2 = 'https://banner.ezeebits.com/banners.json';

        $response1 = $this->curl->simple_get($url1);
        $response2 = $this->curl->simple_get($url2);

        $data1 = json_decode($response1, true);
        $data2 = json_decode($response2, true);




        $urlCollectionBits = [];
        $urlCollectionCargo = [];

        foreach ($data2['data'] as $row) {
            foreach ($row as $al) {
                array_push($urlCollectionBits, $al);
            }
        }

        $urlCollectionBits = array_unique($urlCollectionBits);
        $urlwithCodeBit = [];

        foreach ($urlCollectionBits as $Singleurl) {
            $urlwithCodeBit[$Singleurl] = [];

            foreach ($data2['data'] as $key => $row) {
                if (in_array($Singleurl, $row)) {
                    array_push($urlwithCodeBit[$Singleurl], $key);
                }
            }
        }

        foreach ($data1['data'] as $row) {
            foreach ($row as $al) {
                array_push($urlCollectionCargo, $al);
            }
        }

        $urlCollectionCargo = array_unique($urlCollectionCargo);
        $urlWithCargo = [];

        foreach ($urlCollectionCargo as $Singleurl) {
            $urlWithCargo[$Singleurl] = [];

            foreach ($data1['data'] as $key => $row) {
                if (in_array($Singleurl, $row)) {
                    array_push($urlWithCargo[$Singleurl], $key);
                }
            }
        }

        $val = $this->mergeArrays($urlwithCodeBit, $urlWithCargo);
        // print_r($val);
        $newval = [];
        foreach ($val as $key => &$value) { 
            foreach ($value as &$innerValue) { 
                foreach ($vertexdata as $dataum) {
                    if ($dataum['code'] == $innerValue) {
                        if (!isset($newval[$key])) {
                            $newval[$key] = []; 
                        }
                        array_push($newval[$key], $dataum);
                    }
                }
            }
        }
        foreach ($val as $key => $data) {
            foreach ($data as $row) {
                if (substr($row['zone'], -5) === 'cargo' || in_array($row['url'], $excludedUrls)) {
                    unset($val[$key]);
                    break;  
                }
            }


            $vertexdata = array_values($vertexdata);
        }
        $uniqueStateNames = array_unique(array_column($vertexdata, 'stateName'));

        $final = [];


        $this->load->view('site/config/banner_table', [
            'mergedData' => $newval,
            'count' => $final,
            'uniqueStateNames' => $uniqueStateNames,
            'base_url' => base_url()
        ]);
    } 
     private function mergeArrays($array1, $array2)
    {
        $result = [];

        foreach ($array1 as $key => $value1) {
            $value2 = isset($array2[$key]) ? $array2[$key] : [];
            $result[$key] = array_merge($value1, $value2);
        }

        foreach ($array2 as $key => $value2) {
            if (!isset($array1[$key])) {
                $result[$key] = $value2;
            }
        }

        return $result;
    }
}