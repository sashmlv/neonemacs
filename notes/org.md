### Org-mode:

##### Sql query example from some org file:
```#+name: my-query
#+begin_src sql :cmdline -q :database database-name :dbpassword database-password :dbuser database-user :dbhost localhost :engine postgresql
SELECT * FROM users;
#+end_src
#+name: my-query-result
#+RESULTS: my-query```