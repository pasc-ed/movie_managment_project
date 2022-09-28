{% include "header.html" %}
<div class="container">
    <h1> Add a new Movie</h1>
</div>
<div>
    <form id="addNewMovieForm" action="{{ url_for('add_new_movie') }}" method="post">
        <div class="form-group">
            <label for="movietitle">Movie Title</label>
            <input type="text" class="form-control" name="movietitle" placeholder="Enter title of movie">
        </div>
        <div class="form-group">
            <label for="releaseyear">Release Year</label>
            <input type="text" class="form-control" name="releaseyear" placeholder="Enter a year of release">
        </div>
        <div class="form-group">
            <label for="directorSelect">Pick a director</label>
            <select class="form-control" name="directorSelect">
            {% for director in directors_data %}
                <option value="{{director[0]}}">{{director[1]}}</option>
            {% endfor %}
            </select>
        </div>
        <div class="form-group">
            <label for="actorSelect">Pick the main actor</label>
            <select class="form-control" name="actorSelect">
            {% for actor in actors_data %}
                <option value="{{actor[0]}}">{{actor[1]}}</option>
            {% endfor %}
            </select>
        </div>
        <a class="btn btn-danger" href="{{ url_for('list_movie_table') }}" role="button">Cancel</a> <button type="submit" class="btn btn-primary">Submit</button>
    </form>
</div>
{% include "footer.html" %}