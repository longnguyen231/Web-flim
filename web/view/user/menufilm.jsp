

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="../component/setupCss.jsp" %>
    </head>
    <body>
        <!--Header-->
        <%@include file="../component/header.jsp" %>
        <!--Header-->


        <section class="search_section">
            <div class="container">
                <form action="searchFilm" method="GET" class="search-form d-flex justify-content-center mt-5 mb-4">
                    <input type="text" name="search" class="form-control w-50" placeholder="Search for a film by title..." onchange="this.form.submit()" />
                    <button type="submit" class="btn btn-primary ml-3">Search</button>
                </form>
            </div>
        </section>

        <!-- food section -->


        <section class="food_section layout_padding">
            <div class="container">
                <div class="heading_container heading_center">
                    <h2>
                        Menu film
                    </h2>
                </div>

                

                <ul class="filters_menu">
                    <li class="active" data-filter="*">All</li>
                        <c:forEach items="${requestScope.genres}" var="g">
                        <li data-filter=".${g.name}">${g.name}</li>
                        </c:forEach>
                        <c:forEach items="${requestScope.countries}" var="c">
                        <li data-filter=".${c.countryName}">${c.countryName}</li>
                        </c:forEach>
                </ul>


                <div class="filters-content">
                    <div class="row grid">
                        <c:forEach items="${requestScope.films}" var="f">
                            <div class="col-sm-6 col-lg-4 all ${f.genres.name}">
                                <div class="box">
                                    <div>
                                        <div class="img-box">
                                            <img src="view/images/${f.image}" alt="">
                                        </div>
                                        <div class="detail-box">
                                            <h5>
                                                ${f.title}
                                            </h5>
                                            <p>
                                                ${f.description}
                                            </p>
                                            <div class="options">
                                                <h6>
                                                    Time: ${f.time} minute
                                                </h6>
                                                <a href="film?film=${f.filmId}" class="" style="color: black; text-decoration: none">
                                                    <i class="icon fa fa-solid fa-eye"></i>
                                                </a>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>

        </section>

        <!-- end food section -->

        <!--Footer->
        <%@include file="../component/footer.jsp" %>
        <!--Footer-->

        <!--Script-->
        <%@include file="../component/setupJS.jsp" %>
        <!--Script-->
    </body>
</html>
