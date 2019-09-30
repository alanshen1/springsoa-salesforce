/**
 * Created by cshah on 26/09/19.
 */

({
    doInit: function (c, e, h) {
    },
    postData: function (c, e, h) {
        c.set('v.isProcessing', true);
        var xhr = new XMLHttpRequest();
        var url = 'https://basic-authentication-ws.herokuapp.com/echo';
        xhr.open('POST', url, true);
        xhr.onload = function () {
            if (this.status === 200) {
                c.set('v.isProcessing', false);
                c.set('v.response', this.response);
            }
        };

        xhr.setRequestHeader('Content-Type', 'application/json;charset=UTF-8');
        xhr.send(JSON.stringify({message: c.get('v.message')}));
    }
});