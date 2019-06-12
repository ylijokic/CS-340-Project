function deleteMatch(id) {
    $.ajax({
        url: '/match/' + id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};