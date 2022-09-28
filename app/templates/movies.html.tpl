{% include "header.html" %}
<table class="table table-striped">
    <thead class="thead-dark">
        <tr>
            <th scope="col">Title</th>
            <th scope="col">Release Year</th>
        </tr>
    </thead>
<tbody>
{% for movie in movies_data %}
<tr>    
    <td>{{movie[1]}}</td>
    <td>{{movie[2]}}</td>
</tr>
{% endfor %}
</tbody>
</table>
<div>
    <a class="btn btn-primary" href="{{ url_for('new_movie') }}" role="button">Add new Movie</a>
</div>
{% include "footer.html" %}