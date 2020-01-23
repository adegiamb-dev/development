# SonarQube Tips

SonarQube is used for continuous inspection of code quality by automatic reviews with static analysis of code to:
 - detect bugs
 - code smells
 - security vulnerabilities 



## Tips

#### How to ignore sonar rule to a specifc line of code in c#


Let say you have a class that contains a const for the password column in your database
```
private const string PasswordColumn = "password";
```

SonarQube will say you are breaking [RSPEC-2068](https://rules.sonarsource.com/csharp/type/Vulnerability/RSPEC-2068) Hard-coded credentials are security-sensitive, but this is not true.  You can disable the rule on the one code by adding __//NOSONAR__ at the end of the line

```
private const string PasswordColumn = "password"; //NOSONAR
```