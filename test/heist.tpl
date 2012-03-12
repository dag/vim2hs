<body>
  <bind tag="foo">dynamic_name</bind>
  <p name="${foo}">A paragraph</p>
  <content/>
</body>

<ignore>
  Discarded from rendered output.
</ignore>

<apply template="default">
  <h1>Home Page</h1>
  <p>Welcome to XYZ Inc</p>
</apply>
