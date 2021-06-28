<nav class="navbar fixed-top navbar-expand-lg navbar-dark scrolling-navbar">
  <div class="container">

    <!-- Brand -->
    <strong><%= link_to "Alpha Photography Blog", root_path, class: "navbar-brand ", id: "logo" %></strong>

    <!-- Collapse -->
    <!-- <button
      class="navbar-toggler"
      type="button"
      data-bs-toggle="collapse"
      data-bs-target="#navbarNav"
      aria-controls="navbarNav"
      aria-expanded="false"
      aria-label="Toggle navigation"
    >
      <span class="navbar-toggler-icon"></span>
    </button> -->

    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>


    <!-- Links -->
    <div class="collapse navbar-collapse" id="navbarSupportedContent">


    <!-- Right -->
    <div class="mx-auto mr-auto"></div>
      <ul class="navbar-nav">
        <li class="nav-item active">
          <%= link_to "Home", root_path, class: "nav-link text-gray" %>
        </li>
        <li class="nav-item">
          <%= link_to "About", about_path, class: "nav-link text-gray" %>
        </li>
        <li class="nav-item">
          <%= link_to "Blog", articles_path, class: "nav-link text-gray" %>
        </li>
        <li class="nav-item">
          <a class="nav-link text-gray" href="#">Pricing</a>
        </li>
        <li class="nav-item">
          <a class="nav-link text-gray" href="#">Contact</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
