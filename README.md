<table>
  <thead>
    <th>Tile</th>
    <th>Description</th>
    <th colspan = 3>Actions</th>
  </thead>

  <tbody>
    <% @articles.each do |article| %>
    <tr>
      <td><%= article.title %></td>
      <td><%= article.description %></td>
      <td><%= link_to 'Show', article_path(article) %></td>
      <td><%= link_to 'Edit', edit_article_path(article) %></td>
      <td><%= link_to 'Delete', article_path(article), method: :delete, data: { confirm: "Are you sure?"} %></td>
    </tr>
    <% end %>
  </tbody>
</table>
<p>
  <%= link_to 'Create New Article', new_article_path %> |
  <%= link_to 'Home', root_path %> |
  <%= link_to 'About', about_path %>
</p>
