<?php

include 'conexao.php';

$codigo = $_POST['codigo'];
$name = $_POST['name'];


$sql_verifica = "SELECT * FROM responsibles WHERE codigo = :codigo";

$stmt = $PDO->prepare($sql_verifica);
$stmt->bindParam(':codigo',$codigo);
$stmt->execute();

    if($stmt->rowCount() > 0){
        $retornoApp = array("ENVIO"=>"CODIGO_EXISTENTE");
    }else {
        
        $sql_insert = "INSERT INTO responsibles (codigo,name) values(:codigo,:name);";

$stmt = $PDO->prepare($sql_insert);

$stmt->bindParam(':codigo',$codigo);
$stmt->bindParam(':name',$name);


if($stmt->execute()){
    $retornoApp = array("ENVIO"=>"SUCESSO");
}else {
    $retornoApp = array("ENVIO"=>"ERRO");
}
    }
echo json_encode($retornoApp);

?>
