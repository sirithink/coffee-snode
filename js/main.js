window.Router = Backbone.Router.extend({
    routes: {
        ""         : "home",
        "blog/:id" : "blogDetails",
        "about"    : "about"
    },

    initialize: function () {
        var blog = cache.get('blogs')[0];
        this.headerView = new HeaderView({model: blog.id});
        $('.navbar').html(this.headerView.render().el);
    },

    home: function () {
        var blogs = cache.get('blogs');
        /**
        if (!this.homeView) {
            this.homeView = new HomeView({model: blogs});
            this.homeView.render();
        } else {
            this.homeView.delegateEvents(); // delegate events when the view is recycled
        }
         */
        this.homeView = new HomeView({model: blogs});
        $(".content").html(this.homeView.render().el);
        this.headerView.select('home-menu');
    },

    blogDetails: function (id) {
        var blog, blogs = cache.get('blogs');
        for(var i = 0, n = blogs.length; i < n; i++){
            if (blogs[i]['id'] == id){
                blog = blogs[i];
                break;
            }
        }
        $('.content').html(new BlogItemView({model: blog}).render().el);
        this.headerView.select('blog-menu');
    },
    
    about: function () {
        if (!this.aboutView) {
            this.aboutView = new AboutView();
            this.aboutView.render();
        }
        $('.content').html(this.aboutView.el);
        this.headerView.select('about-menu');
    }
});

templateLoader.load(["HomeView", "HeaderView", "BlogItemView", "AboutView"],
    function () {
        $.blockUI({
            message: "加载中，请稍后...",
            css: {border:'none',padding:'15px',backgroundColor:'#000','-webkit-border-radius':'10px','-moz-border-radius':'10px',opacity:.5,color:'#fff'}
        });
        $.getJSON('http://snode.rs.af.cm/json?callback=?', function(data) {
            cache.put('blogs', data);
            $.unblockUI();
            app = new Router();
            Backbone.history.start();
        });
    }
);