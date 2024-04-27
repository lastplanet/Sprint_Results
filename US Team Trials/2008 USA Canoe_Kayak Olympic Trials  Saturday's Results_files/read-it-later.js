/********************************************
	* NewsOK Pro - Reat it later
	* Version 1.0 - 04/2018
    * Original code by Jake Sullivan
	* Updated 04/2018 by Stephane Kadja
********************************************/

// Can we use localstorage?
function storageAvailable(type) {
    try {
        var storage = window[type],
            x = '__storage_test__';
        storage.setItem(x, x);
        storage.removeItem(x);
        return true;
    }
    catch(e) {
        return false;
    }
}
if (storageAvailable('localStorage')) {

    // Purge old bookmarks
    function purgeBookmarks() {
        if ( !localStorage.getItem('nokBookmarksExpire') ) {
        	var expire = new Date().setFullYear(new Date().getFullYear() + 5); // 5 years from today
        	localStorage.setItem('nokBookmarksExpire', expire);
        } else {
        	var expire = localStorage.getItem('nokBookmarksExpire');
        }
        var now = Date.now();
        if (now > expire) {
            localStorage.removeItem('nokBookmarks'); // Remove bookmarks after set time
        }
    }
    purgeBookmarks();

    // Bookmarks
    function initBookmarks() {
        //if(!parseInt(localStorage.getItem('loadBookmarks'))){
            //var nokBookmarks = [];
            //localStorage.setItem('nokBookmarks', JSON.stringify(nokBookmarks));
            
            /*
            var profile = JSON.parse(localStorage.getItem('profile'));
            var profileId = 0;
            if(typeof(profile) !== "undefined" && profile !== null && profile.hasOwnProperty('id')) {
              profileId = parseInt(profile.id);
            }
            if(profileId) {
            */
            
            if ($('.top-links a#topLogout').is(':visible')) { // user is logged in
                $.get('/webapi/ReadItLater', function (data) {
                    localStorage.setItem('nokBookmarks', JSON.stringify(data));
                    //localStorage.setItem('loadBookmarks', 1);
                });
            //} else {
                var nokBookmarks = JSON.parse(localStorage.getItem('nokBookmarks'));
                if(typeof(nokBookmarks) !== "undefined" && nokBookmarks !== null) {
                    bookmarkCount(nokBookmarks.length);
                }
              //}
            }
        highlightBookmarks();
    }
    setTimeout(function() {
        initBookmarks();
    }, 1000);

    // Highlight active bookmarks
    function highlightBookmarks() {
    	var nokBookmarks = JSON.parse(localStorage.getItem('nokBookmarks'));
        if (!$('.top-links .nav-link[href="/login"]').length) { // user is logged in
            $('.bookmark-it').each(function() {
            	var id = $(this).data('id');
            	var item = checkBookmark(nokBookmarks, id, 'id');
            	if (item != -1) {
            		$(this).addClass('saved');
            	} else {
            		$(this).removeClass('saved');
            	}
            });
        }
    }

    // Bookmark count
    function bookmarkCount(count) {
        if ($('.top-links a#topLogout').is(':visible')) { // user is logged in
            var bug = $('#ril-count');
            if (count > 0) {
                bug.html(count).removeClass('d-none');
            } else {
                bug.addClass('d-none');
            }
        }
    }

    // Bookmark button tap
    $(document).on('click', '.bookmark-it', function() {
      var url = '/webapi/asset/' + $(this).data('id');
      $.ajax({
        url    : url,
        success: function (content) {
    	      var params = {
    	          id        : content.id,
    	          title     : content.title,
    	          url       : content.url,
    	          img       : content.img,
    	          type      : content.type,
                section   : content.section,
    	          timestamp : new Date().getTime()
            };

            if (location.href.indexOf("newsokapp=true") != -1) {
                ga('send', 'event', 'Read it Later App', params.type);
                if (params.type == "article") {
                    params.type = 1;
                    params.img = "https://cdn2.newsok.biz/cache/sq150-"+params.img+".jpg";
                } else if (params.type == "gallery") {
                    params.img = "https://cdn2.newsok.biz/cache/sq150-"+params.img+".jpg";
                    params.type = 31;
                    params.title = "Gallery: "+params.title;
                } else if (params.type == "video") {
                    params.type = 15;
                }
                location.href = "readitlater://?params=starthere&url="+encodeURIComponent(params.url)+"&title="+encodeURIComponent(params.title)+"&moduleId="+encodeURIComponent(params.id)+"&moduleTypeId="+encodeURIComponent(params.type)+"&photo="+encodeURIComponent(params.img);
            } else {
                $(this).toggleClass('saved');
                updateBookmarks(params); // update bookmarks
                ga('send', 'event', 'Pro Read it Later', params.type);
            }
        }
      });
    });

    // See if item is already bookmarked
    function checkBookmark(myArray, searchTerm, property) {
        for(var i = 0, len = myArray.length; i < len; i++) {
            if (myArray[i][property] === searchTerm) return i;
        }
        return -1;
    }

    // Update bookmarks
    function updateBookmarks(params) {
        var currentBookmarks = JSON.parse(localStorage.getItem('nokBookmarks')); // store a temp array of current bookmarks
        var item = checkBookmark(currentBookmarks, params.id, 'id');
        if (item != -1) {
            // Unlike it
            $.post('/webapi/ReadItLater/delete', params, function(response) {
                if (response.hasOwnProperty('success') && response.success == true) {
                    ga('send', 'event', 'Pro Bookmark button', 'unsave', params, {'nonInteraction': 1});
                } else {
                    if (response.hasOwnProperty('errors')){
                        alert(response.errors);
                        return;
                    }else{
                        alert("error occurred, try again");
                        return;
                    }
                }}).fail(function() {
                window.location = "/my/tools/read-it-later";
            });
            currentBookmarks.splice(item, 1); // remove id from array
            $('#bookmarks li[data-id=' +params.id+ ']').slideToggle(200, function() { // remove form list
                $(this).remove();
            });
        } else {
            // Like it
            $.post('/webapi/ReadItLater/create', params, function(response) {
                if (response.hasOwnProperty('success') && response.success == true) {
                    ga('send', 'event', 'Pro Bookmark button', 'save', params, {'nonInteraction': 1});
                } else {
                    if (response.hasOwnProperty('errors')){
                        alert(response.errors);
                    }else{
                        alert("error occurred, try again")
                        return;
                    }
                }}).fail(function() {
                window.location = "/my/tools/read-it-later";
            });
            currentBookmarks.push(params); // add id to array
        }
        localStorage.setItem('nokBookmarks', JSON.stringify(currentBookmarks)); // store the updated array
        bookmarkCount(currentBookmarks.length);
        highlightBookmarks();
    }

    // Toggle bookmarks pane
    $('#bookmarkTab').on('click', function(){
        $('body').toggleClass('show-bookmarks');
    });

    // toggle settings
    $('button[data-toggle-action=settings]').click(function() {
        if ($('#ril-settings').is('.active')) {
            $('#bookmarks').removeClass('d-none');
            $('#ril-settings').removeClass('active');
        } else {
            $('#bookmarks').addClass('d-none');
            $('#ril-settings').addClass('active');
        }
    });

    // purge
    $('#purge').on('submit', function(e) {
        e.preventDefault();
        var val = $( this ).serializeArray();
        for(var i = 0, len = val.length; i < len; i++) {
            if (val[i].name == 'purgeTime') {
                if (val[i].value == 'week') {
                    var expire = new Date().setDate(new Date().getDate() + 7);
                } else if (val[i].value == 'month') {
                    var expire = new Date().setMonth(new Date().getMonth() + 1);
                } else if (val[i].value == 'never') {
                    var expire = new Date().setFullYear(new Date().getFullYear() + 5);
                }
                localStorage.setItem('nokBookmarksExpire', expire);
            }

            if (val[i].name == 'deleteNow' && val[i].value == 'on') {
                $.post('/webapi/ReadItLater/purge');
                localStorage.setItem('nokBookmarks', JSON.stringify([]));
                initBookmarks();
                $('#bookmarks ul').empty(); // remove all items
            }
        }
        savedCheck();
        /*
        $('.alert-success-wrap').addClass('active').delay(4000).queue(function() {
            $('.alert-wrap').removeClass('active').dequeue();
        });
        */
    });

}
