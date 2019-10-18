<?php 

    $dsn = "mysql:host=107.161.183.171;dbname=evsinvc_Servidor";
    $user = "evsinvc_admin";
    $pass = "Evs162636";
    
    try{
        
        $PDO = new PDO($dsn,$user,$pass);
        
    }catch (PDOException $erro){
        echo("Erro: " . $erro.getMessage());
        exit;
    }


?>