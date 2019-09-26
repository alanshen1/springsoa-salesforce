/**
 * Created by cshah on 26/09/19.
 */

({
    doInit: function (c, e, h) {
        var xhr = new XMLHttpRequest();
        var url = 'https://reqres.in/api/users';
        xhr.open('GET', url, true);
        xhr.onload = function () {
            if (this.status === 200) {
                var response = JSON.parse(this.responseText);
                c.set('v.records', response.data);
            }
        };
        xhr.send();
    }
});