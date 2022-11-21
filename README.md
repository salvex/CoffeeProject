# CoffeeProject

------


-------

## Notes

This is an "university project" for the course "System Web Design" at MS Computer Engineering @unipa realized using **Jakarta\Java EE** as back-end and **JavaScript\jQuery & JSP** as front-end, running on **Apache Tomcat (9.0.55)** middleware. Feel free to use it as "example" or "inspiration" (you should not take the entire project and use it as it was yours, it's not "ethical" 😅)

## Contents

#### File Tree (back-end)

- src
  - main
    - java
      - com
        - coffee
          - controller
            - **LoginController.java**
            - **MachineController.java**
            - **LogoutController.java**
            - **UserController.java**
            - **RegController.java**
          - model
            - **Machine.java**
            - **MachineService.java**
            - **User.java**
            - **UserService.java**
            - **Product.java**
            - **ProductService.java**
          - util
            - **AuthFilter.java**
            - **DBConnector.java**
            - **SecurePassword.java**
            - **SessionFilter.java**
        - lambdaworks
          - *dependencies necessary to make SecurePassword.java* works

#### File tree (front-end)

WiP!

### Third party technologies 

<a href="https://tomcat.apache.org/taglibs/standard/JSTL">JSTL (JSP - Standard Tag Library): </a> The JSP Standard Tag Library (*JSTL*) represents a set of tags to simplify the JSP development. 

<a href="https://github.com/wg/scrypt">SCryptUtil</a>: Java implementation of "SCrypt" key derivation

<a href="https://www.mysql.com/products/connector/">MySQL Connector</a>: standards-based drivers for JDBC

**org.json**: simple Java based toolkit for JSON. You can use *org*.*json* to encode or decode JSON data

### Installation

#### ECLIPSE

You can import "CoffeProject.war" from this repository (**FIle > Import > WAR-file**) (*apache tomcat 9.0.55 is needed to run the server*). Start the server from the IDE (Run "Apache Tomcat") 

#### MySQL 

simply execute the query inside "coffedb_updated.sql" and you should be ready!

### GNU License 

```
This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
```
