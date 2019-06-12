function deleteMachine(id) {
    $.ajax({
        url: '/machine/' + id,
        type: 'DELETE',
        success: function (result) {
            window.location.reload(true);
        }
    })
};