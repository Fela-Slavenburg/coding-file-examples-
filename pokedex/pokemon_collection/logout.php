<?php
session_start();
session_destroy();
header(header: "Location:../start_page/start_page.html");
exit();
?>