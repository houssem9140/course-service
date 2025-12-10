# Thunder Client Testing Guide - Course Service SOAP API

A complete guide for testing the Course Service SOAP Web Service using Thunder Client with ready-to-use XML requests.

## Quick Start

1. Open Thunder Client extension in VS Code
2. Create a new request
3. Set **Method**: `POST`
4. Set **URL**: `http://localhost:8082/course-service`
5. Add **Header**: `Content-Type: text/xml; charset=UTF-8`
6. Copy-paste the XML body from the requests below
7. Click **SEND**

---

## Testing Requests

### 1. Get All Courses

**Purpose**: Retrieve all courses from the database

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)**:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:getAllCourses/></soap:Body></soap:Envelope>
```

**Expected Response**: Status 200 OK with list of all courses

---

### 2. Add a New Course

**Purpose**: Create a new course in the database

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)** - Change code to make it unique each time:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:addCourse><code>MYCLASS001</code><name>My Test Course</name><description>Testing course creation</description><credits>3</credits><professor>Dr. Test</professor><semester>Spring 2025</semester><maxStudents>25</maxStudents><room>Z505</room><schedule>Monday 18h-20h</schedule></ser:addCourse></soap:Body></soap:Envelope>
```

**Notes**:
- Change `<code>MYCLASS001</code>` to a unique code each time
- Change `<name>My Test Course</name>` to your course name
- Room and schedule must be available (not already booked)

**Expected Response**: Status 200 OK with created course details

---

### 3. Get Course by Code

**Purpose**: Search for a course by its code

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)** - Use a code from your database:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:getCourseByCode><code>CS101</code></ser:getCourseByCode></soap:Body></soap:Envelope>
```

**Notes**:
- Change `CS101` to any course code you want to find
- Use a code you created in test 2 to see your course

**Expected Response**: Status 200 OK with course details or error if not found

---

### 4. Get Course by ID

**Purpose**: Retrieve a specific course by its ID

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)**:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:getCourseById><id>1</id></ser:getCourseById></soap:Body></soap:Envelope>
```

**Notes**:
- Change `<id>1</id>` to different IDs to test
- Start with ID 1 and increment to find courses

**Expected Response**: Status 200 OK with course details

---

### 5. Get Courses by Professor

**Purpose**: Find all courses taught by a specific professor

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)**:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:getCoursesByProfessor><professor>Dr. Johnson</professor></ser:getCoursesByProfessor></soap:Body></soap:Envelope>
```

**Notes**:
- Change `Dr. Johnson` to any professor name
- Try `Dr. Smith`, `Dr. Test`, etc.

**Expected Response**: Status 200 OK with list of courses by that professor

---

### 6. Get Courses by Semester

**Purpose**: Retrieve all courses in a specific semester

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)**:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:getCoursesBySemester><semester>Automne 2024</semester></ser:getCoursesBySemester></soap:Body></soap:Envelope>
```

**Notes**:
- Change `Automne 2024` to any semester
- Try `Spring 2025`, `Fall 2024`, etc.

**Expected Response**: Status 200 OK with list of courses in that semester

---

### 7. Check Room Availability (Available)

**Purpose**: Check if a room is available for a time slot

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)** - Room that should be available:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:isRoomAvailable><room>A101</room><schedule>Wednesday 10h-12h</schedule></ser:isRoomAvailable></soap:Body></soap:Envelope>
```

**Expected Response**: Status 200 OK with `true` (room is available)

---

### 8. Check Room Availability (Occupied)

**Purpose**: Check if a room that's already booked returns false

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)** - Room that's already booked:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:isRoomAvailable><room>D404</room><schedule>Jeudi 09h-11h</schedule></ser:isRoomAvailable></soap:Body></soap:Envelope>
```

**Expected Response**: Status 200 OK with `false` (room is occupied)

---

### 9. Update Course

**Purpose**: Modify an existing course

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)**:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:updateCourse><id>1</id><code>CS101_UPDATED</code><name>Advanced Computer Science</name><description>Updated description</description><credits>4</credits><professor>Dr. Updated</professor><semester>Spring 2025</semester><maxStudents>35</maxStudents><room>A102</room><schedule>Wednesday 14h-16h</schedule></ser:updateCourse></soap:Body></soap:Envelope>
```

**Notes**:
- Change `<id>1</id>` to the ID of the course you want to update
- Update the other fields as needed

**Expected Response**: Status 200 OK with updated course details

---

### 10. Delete Course

**Purpose**: Delete a course from the database

**URL**: `http://localhost:8082/course-service`
**Method**: `POST`
**Header**: `Content-Type: text/xml; charset=UTF-8`

**Body (XML)**:
```xml
<?xml version="1.0" encoding="UTF-8"?><soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.course.university.com/"><soap:Body><ser:deleteCourse><id>999</id></ser:deleteCourse></soap:Body></soap:Envelope>
```

**Notes**:
- Change `<id>999</id>` to the ID you want to delete
- ID 999 should not exist, so you'll get an error message (which is correct behavior)

**Expected Response**: Status 200 OK with error message if ID not found

---

## Complete Testing Workflow

Follow this order to test all functionality:

1. **Test 1**: Get All Courses (see what exists)
2. **Test 2**: Add a New Course (create MYCLASS001)
3. **Test 3**: Get Course by Code (search for MYCLASS001)
4. **Test 4**: Get Course by ID (use ID 1)
5. **Test 5**: Get Courses by Professor (search by professor name)
6. **Test 6**: Get Courses by Semester (filter by semester)
7. **Test 7**: Check Room Availability (available room)
8. **Test 8**: Check Room Availability (occupied room)
9. **Test 9**: Update Course (modify ID 1)
10. **Test 10**: Delete Course (try to delete ID 999)

---

## Troubleshooting

### Error: 415 Unsupported Media Type
**Solution**: Make sure your header is exactly:
```
Content-Type: text/xml; charset=UTF-8
```

### Error: 500 Internal Server Error
**Solution**: 
- Check if the service is running
- Verify the XML syntax is correct
- For addCourse: Make sure room and schedule are not already booked

### Error: Unexpected character in XML
**Solution**:
- Don't add line breaks in the XML - it must be on one line
- Copy-paste the entire request as-is

---

## Service Information

- **Service URL**: `http://localhost:8082/course-service`
- **WSDL Endpoint**: `http://localhost:8082/course-service?wsdl`
- **Database**: MySQL (university_db)
- **All Responses**: XML SOAP format

---

## Additional Notes

- The service automatically generates course IDs
- Room availability is checked to prevent double-booking
- All dates and times are in 24-hour format
- Professor names and semester values are case-sensitive
- The service returns detailed error messages in SOAP faults

---

**Last Updated**: December 10, 2025
**Version**: 1.0
