<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.neil.ecoblue.model.Account" %>
<% Account account = (Account) session.getAttribute("admin");%>
<nav id="sidebar" class="active">
    <div class="sidebar-header my-5">
        <h3>Ecoblue</h3>
        <strong>EB</strong>
    </div>

    <ul class="list-unstyled components mb-5">
        <li class="nav-item">
            <a class="nav-link" href="/login"><i class="fas fa-database"></i> CMS</a>
        </li>
        <% if(account!=null){%>
        <% if(account.getType()==2){%>
            <li class="nav-item">
                <a class="nav-link" href="/accounts"><i class="fas fa-users"></i> Accounts</a>
            </li>
        <% }%>
        <% }%>
        <li class="nav-item">
            <a class="nav-link" href="/convert"><i class="fas fa-sync"></i> Convert</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/redeem"><i class="fas fa-download"></i> Redeem</a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="/history"><i class="fas fa-history"></i> History</a>
        </li>
        <% if(account!=null){%>
        <li class="nav-item">
            <a class="nav-link" href="/logout"><i class="fas fa-power-off"></i> Logout</a>
        </li>
        <% }%>
    </ul>

</nav>