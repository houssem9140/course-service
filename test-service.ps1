#!/usr/bin/env powershell

# Script de test du service SOAP Course Service
# Teste automatiquement toutes les methodes disponibles

$serviceUrl = "http://localhost:8082/course-service"

Write-Host "`n=====================================" -ForegroundColor Cyan
Write-Host "  Test Automatique - Course Service" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""

# Fonction pour faire un appel SOAP
function Invoke-SoapRequest {
    param(
        [string]$MethodName,
        [string]$SoapBody
    )
    
    $soapRequest = @"
<?xml version="1.0" encoding="UTF-8"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" 
               xmlns:ser="http://service.course.university.com/">
    <soap:Body>
        $SoapBody
    </soap:Body>
</soap:Envelope>
"@

    try {
        Write-Host "[TEST] Appel de $MethodName..." -ForegroundColor Yellow
        $response = Invoke-WebRequest -Uri $serviceUrl `
          -Method Post `
          -ContentType "text/xml; charset=UTF-8" `
          -Body $soapRequest `
          -ErrorAction Stop
        
        Write-Host "[SUCCESS] $MethodName - Reponse reçue" -ForegroundColor Green
        Write-Host ""
        return $true
    }
    catch {
        Write-Host "[ERROR] $MethodName - Erreur: $($_.Exception.Message)" -ForegroundColor Red
        Write-Host ""
        return $false
    }
}

# Verification que le service est accessible
Write-Host "[CHECK] Verification que le service est accessible..." -ForegroundColor Cyan
Start-Sleep -Seconds 2
try {
    $wsdl = Invoke-WebRequest -Uri "$serviceUrl`?wsdl" -ErrorAction Stop
    Write-Host "[SUCCESS] Service accessible!" -ForegroundColor Green
    Write-Host "WSDL disponible a: $serviceUrl`?wsdl" -ForegroundColor White
    Write-Host ""
}
catch {
    Write-Host "[ERROR] Service non accessible! Verifiez que le service est demarré." -ForegroundColor Red
    Write-Host "Commande pour demarrer le service:" -ForegroundColor Yellow
    Write-Host "  java -jar target/course-service-1.0-SNAPSHOT.jar" -ForegroundColor Yellow
    exit 1
}

# Generer des codes uniques
$timestamp = Get-Date -Format "HHmmss"
$courseCode1 = "JAVA" + $timestamp
$courseCode2 = "DBSQL" + $timestamp
$courseCodeUpdated = "JAVA_UPDATE" + $timestamp

# Test 1: Ajouter un premier cours
Write-Host "========== TEST 1: Ajouter un cours ==========" -ForegroundColor Magenta
$addCourseBody = @"
<ser:addCourse>
    <code>$courseCode1</code>
    <name>Programmation Java</name>
    <description>Introduction a la programmation Java</description>
    <credits>3</credits>
    <professor>Dr. Smith</professor>
    <semester>Automne 2024</semester>
    <maxStudents>30</maxStudents>
    <room>F101</room>
    <schedule>Lundi 15h-17h</schedule>
</ser:addCourse>
"@
Invoke-SoapRequest "addCourse" $addCourseBody | Out-Null

# Test 2: Ajouter un deuxième cours
Write-Host "========== TEST 2: Ajouter un second cours ==========" -ForegroundColor Magenta
$addCourse2Body = @"
<ser:addCourse>
    <code>$courseCode2</code>
    <name>Bases de Donnees</name>
    <description>Introduction aux bases de donnees SQL</description>
    <credits>4</credits>
    <professor>Dr. Johnson</professor>
    <semester>Automne 2024</semester>
    <maxStudents>25</maxStudents>
    <room>G202</room>
    <schedule>Samedi 10h-12h</schedule>
</ser:addCourse>
"@
Invoke-SoapRequest "addCourse (2e)" $addCourse2Body | Out-Null

# Test 3: Lister tous les cours
Write-Host "========== TEST 3: Lister tous les cours ==========" -ForegroundColor Magenta
$getAllCoursesBody = "<ser:getAllCourses/>"
Invoke-SoapRequest "getAllCourses" $getAllCoursesBody | Out-Null

# Test 4: Obtenir un cours par code
Write-Host "========== TEST 4: Obtenir un cours par code ==========" -ForegroundColor Magenta
$getCourseByCodeBody = @"
<ser:getCourseByCode>
    <code>$courseCode1</code>
</ser:getCourseByCode>
"@
Invoke-SoapRequest "getCourseByCode" $getCourseByCodeBody | Out-Null

# Test 5: Obtenir les cours d'un professeur
Write-Host "========== TEST 5: Obtenir les cours par professeur ==========" -ForegroundColor Magenta
$getCoursesByProfessorBody = @"
<ser:getCoursesByProfessor>
    <professor>Dr. Smith</professor>
</ser:getCoursesByProfessor>
"@
Invoke-SoapRequest "getCoursesByProfessor" $getCoursesByProfessorBody | Out-Null

# Test 6: Obtenir les cours par semestre
Write-Host "========== TEST 6: Obtenir les cours par semestre ==========" -ForegroundColor Magenta
$getCoursesBySemesterBody = @"
<ser:getCoursesBySemester>
    <semester>Automne 2024</semester>
</ser:getCoursesBySemester>
"@
Invoke-SoapRequest "getCoursesBySemester" $getCoursesBySemesterBody | Out-Null

# Test 7: Vérifier disponibilité salle libre
Write-Host "========== TEST 7: Verifier disponibilite salle libre ==========" -ForegroundColor Magenta
$isRoomAvailableBody = @"
<ser:isRoomAvailable>
    <room>C303</room>
    <schedule>Mercredi 10h-12h</schedule>
</ser:isRoomAvailable>
"@
Invoke-SoapRequest "isRoomAvailable (salle libre)" $isRoomAvailableBody | Out-Null

# Test 8: Vérifier disponibilité salle occupée
Write-Host "========== TEST 8: Verifier disponibilite salle occupee ==========" -ForegroundColor Magenta
$isRoomOccupiedBody = @"
<ser:isRoomAvailable>
    <room>D404</room>
    <schedule>Jeudi 09h-11h</schedule>
</ser:isRoomAvailable>
"@
Invoke-SoapRequest "isRoomAvailable (salle occupee)" $isRoomOccupiedBody | Out-Null

# Test 9: Obtenir un cours par ID
Write-Host "========== TEST 9: Obtenir un cours par ID ==========" -ForegroundColor Magenta
$getCourseByIdBody = @"
<ser:getCourseById>
    <id>1</id>
</ser:getCourseById>
"@
Invoke-SoapRequest "getCourseById" $getCourseByIdBody | Out-Null

# Test 10: Mettre à jour un cours
Write-Host "========== TEST 10: Mettre a jour un cours ==========" -ForegroundColor Magenta
$updateCourseBody = @"
<ser:updateCourse>
    <id>1</id>
    <code>$courseCodeUpdated</code>
    <name>Programmation Java Avancee</name>
    <description>Programmation Java avec concepts avances</description>
    <credits>4</credits>
    <professor>Dr. Smith</professor>
    <semester>Automne 2024</semester>
    <maxStudents>25</maxStudents>
    <room>A101</room>
    <schedule>Lundi 10h-12h</schedule>
</ser:updateCourse>
"@
Invoke-SoapRequest "updateCourse" $updateCourseBody | Out-Null

# Test 11: Supprimer un cours (ID invalide)
Write-Host "========== TEST 11: Supprimer un cours (ID invalide) ==========" -ForegroundColor Magenta
$deleteCourseFakeBody = @"
<ser:deleteCourse>
    <id>999999</id>
</ser:deleteCourse>
"@
Invoke-SoapRequest "deleteCourse (ID inexistant)" $deleteCourseFakeBody | Out-Null

Write-Host "=====================================" -ForegroundColor Cyan
Write-Host "  Tests termines!" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan
Write-Host ""
