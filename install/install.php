<?php
if(is_file("install.lock")){
    die(json_encode('true'));
}else{
    die(json_encode('false'));
}