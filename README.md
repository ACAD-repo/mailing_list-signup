# Perl CGI Signup Form on Windows (XAMPP)

This guide explains how to run an HTML signup form (`signup.html`) that submits data to a Perl CGI script (`mailinglist.pl`) on **Windows**, using **XAMPP (Apache)** and **Strawberry Perl**.

The CGI script saves submitted names and emails into a text file (`submission.txt`).

---

## 1. Requirements

Install the following software **in this order**:

### 1.1 XAMPP (Apache Web Server)
- Download: https://www.apachefriends.org/
- Install to the default location:
  ```
  C:\xampp\
  ```

### 1.2 Strawberry Perl (64-bit)
- Download: https://strawberryperl.com/
- Default install location:
  ```
  C:\Strawberry\
  ```

Verify Perl installation:
```cmd
perl -v
```

---

## 2. Directory Structure

Create the following files and directories:

```
C:\xampp\htdocs\
    signup.html

C:\xampp\cgi-bin\
    mailinglist.pl
    submission.txt
```

---

## 3. Apache CGI Configuration

Edit:
```
C:\xampp\apache\conf\httpd.conf
```

Ensure:
```apache
LoadModule cgi_module modules/mod_cgi.so
```

Add at the end:
```apache
ScriptAlias /cgi-bin/ "C:/xampp/cgi-bin/"

<Directory "C:/xampp/cgi-bin">
    AllowOverride None
    Options +ExecCGI
    AddHandler cgi-script .pl
    Require all granted
</Directory>
```

Restart Apache via XAMPP Control Panel.

---

## 4. HTML Form (`signup.html`)

```html
<form action="/cgi-bin/mailinglist.pl" method="post">
  <label>Name:</label>
  <input type="text" name="name">

  <label>Email:</label>
  <input type="text" name="email">

  <input type="submit" value="Submit">
</form>
```

---

## 5. Perl CGI Script (`mailinglist.pl`)

Find Perl path:
```cmd
where perl
```

Example script:
```perl
#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;
use CGI;

my $q = CGI->new;
my $name  = $q->param('name')  // '';
my $email = $q->param('email') // '';

open(my $fh, '>>', 'C:/xampp/cgi-bin/submission.txt')
    or die "Cannot open submission.txt";

print $fh "$name\t$email\n";
close $fh;

print $q->header('text/html; charset=UTF-8');
print "<h1>Thank you!</h1>";
```

---

## 6. Permissions

Right-click `submission.txt` → Properties → Security → Allow Write.

---

## 7. Start Apache engine

Run the XAMPP Control Panel and start the Apache service.

---

## 8. Testing

- CGI test:
  http://localhost/cgi-bin/mailinglist.pl
  You should see "Thank You!"
- Form:
  http://localhost/signup.html
  You should see the mailing-list signup form.

---

## 9. Troubleshooting

Check:
```
C:\xampp\apache\logs\error.log
```

Common issues:
- Internal Server Error → wrong shebang
- Tabs only → wrong HTML `name`
- No output → missing CGI header
