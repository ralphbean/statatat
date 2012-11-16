function subscribe(link) {
    $.ajax(link, {
        success: function(json, stat, xhr) {
            var sel = $("#" + json.repo.name);
            sel.toggleClass('btn-success');
            sel.toggleClass('btn-danger');

            if (json.repo.enabled) {
                sel.html("Disable");
            } else {
                sel.html("Enable");
            }
        },
        error: function(json, stat, xhr) {
            // TODO -- this could be better.
            console.log('error');
            console.log(json);
        },
    });
}

function revoke(link) {
    $.ajax(link, {
        success: function(json, stat, xhr) {
            var sel = $("#" + json.value);
            sel.parent().parent().hide('slow');
        },
        error: function(json, stat, xhr) {
            // TODO -- this could be better.
            console.log('error');
            console.log(json);
        },
    });
}
