simple =
  <br/>

simpleAttr =
  <hr class="wide"/>

block =
  <p>Hello</p>

blockAttr =
  <a href=(Post 123)>Post #123</a>

splice n =
  <a href=(Post n)>Post #<% n %></a>

list =
  <%>
    <p>Hello</p>
    <p>World</p>
  </%>

qq =
  [hsx| <a href=(Post 123)>Post #123</a> |]
