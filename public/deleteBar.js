function deleteBar(id) {
    $.ajax({
        url: '/bar/' + id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};

