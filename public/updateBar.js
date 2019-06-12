function updateBar(id) {
    $.ajax({
        url: '/bar/' + id,
        type: 'PUT',
        data: $('#update-bar').serialize(),
        success: function (result) {
            window.location.replace("./");
        }
    })
};