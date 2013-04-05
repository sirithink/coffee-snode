window.HeaderView = Backbone.View.extend({
    render: function () {
        $(this.el).html(this.template({id: this.model}));
        return this;
    },
    
    select: function(menuItem) {
        $('.nav li').removeClass('active');
        $('.' + menuItem).addClass('active');
    }
});