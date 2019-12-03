# Exception

## python
1. `try: ... except <name>: ... else: ...`
    ```python
    >>> try:
    ...     3 / 0
    ... except ZeroDivisionError:
    ...     print("ZeroDivisionError")
    ... else:
    ...     print("sucess")
    ...
    ZeroDivisionError
    >>>
    ```
2. raise Exception
   ```python
    >>> def foo(a):
    ...     if a < 1:
    ...             raise Exception("invalid value", a)
    ...     else:
    ...             print(a)
    ...
    >>> foo(2)
    2
    >>> foo(0)
    Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
    File "<stdin>", line 3, in foo
    Exception: ('invalid value', 0)
    ```
    
    ```python
    >>> try:
    ...     foo(0)
    ... except Exception as e:
    ...     print(e.args)
    ... else:
    ...     print("success")
    ...
    ('invalid value', 0)
   ```
   ```python
    >>> try:
    ...     foo(0)
    ... finally:
    ...     print("error!")
    ...     exit()
    ...
    error!
    ```
3. Self define
   ```python
    >>> class Networkerror(RuntimeError):
    ...     def __init__(self, arg):
    ...             self.args = arg
    ...
    >>> try:
    ...     raise Networkerror("404")
    ... except Networkerror as e:
    ...     print(e.args)
    ...
    ('4', '0', '4')
   ```
