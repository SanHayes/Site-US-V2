<?php
$status=unlink('../install/install.lock');    
if($status){  
    echo "安装已重置";
}else{  
    echo "Sorry!";
}