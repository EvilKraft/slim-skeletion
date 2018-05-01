/**
 * Created by PhpStorm.
 * Author: Konstantin Kaluzhnikov k.kaluzhnikov@gmail.com
 * Date: 22.08.2017
 */

function TenderChat(chatId, status, config){
    this.chatId	= chatId;
    this.status	= status;
    this.lastId = 0;

    this.config = config || {
            update_path : '/chat/update',
            save_path   : '/chat/save'
        };



    this.update = function() {
        var self = this;

        var chatContainer = $('[data-chatid="' + self.chatId + '"]');

        var isOpen = !chatContainer.hasClass('collapsed-box');

        $.ajax({
            url: self.config.update_path,
            type: "POST",
            dataType: "json",
            data: {
                chatId: self.chatId,
                lastId: self.lastId,
                isOpen: isOpen
            },
	        statusCode: {
		        201: function(result, textStatus, jqXHR) {
			        if (result.status == 'OK') {

				        var badge    = $(chatContainer).find('span.badge');
				        var unreaded = (isOpen == true) ? 0 : parseInt(badge.text());

				        var container = $(chatContainer).find('.direct-chat-messages');

				        for (var i = 0; i < result.data.items.length; i++) {

					        var item = result.data.items[i];
					        var chatItem = '';

					        if (item.isMe == 1) {
						        chatItem = '<div class="direct-chat-msg right">'
							        + '<div class="direct-chat-info clearfix">'
							        + '<span class="direct-chat-name pull-right">' + item.name + '</span>'
							        + '<span class="direct-chat-timestamp pull-left">' + item.createdAt + '</span>'
							        + '</div>'
							        + '<i class="fa fa-user-circle-o fa-3x direct-chat-img text-primary"></i>'
							        + '<div class="direct-chat-text">' + item.text + '</div>'
							        + '</div>';
					        } else {
						        chatItem = '<div class="direct-chat-msg">'
							        + '<div class="direct-chat-info clearfix">'
							        + '<span class="direct-chat-name pull-left">' + item.name + '</span>'
							        + '<span class="direct-chat-timestamp pull-right">' + item.createdAt + '</span>'
							        + '</div>'
							        + '<i class="fa fa-user-circle-o fa-3x direct-chat-img text-muted"></i>'
							        + '<div class="direct-chat-text">' + item.text + '</div>'
							        + '</div>';

						        if(!item.readedAt){
							        unreaded++;
						        }
					        }

					        container.append(chatItem);

					        self.lastId = item.id;
				        }

				        $(badge).text(unreaded);
				        $(badge).attr('data-original-title', unreaded+' new messages');

				        $(container).animate({scrollTop: $(container)[0].scrollHeight});


				        allUnreadedCount = result.data.newMsgs.length;
				        allUnreadedList = '';

				        for(var i = 0; i < result.data.newMsgs.length; i++){
					        allUnreadedList += result.data.newMsgs[i];
				        }

				        if(allUnreadedCount > 0){
					        $('#allUnreadedCountUp').html(allUnreadedCount);
					        $('#allUnreadedCountLeft').html(allUnreadedCount);

					        $('#allUnreadedCountUp').show();
					        $('#allUnreadedCountLeft').show();
				        }else{
					        $('#allUnreadedCountUp').html('');
					        $('#allUnreadedCountLeft').html('');

					        $('#allUnreadedCountUp').hide();
					        $('#allUnreadedCountLeft').hide();
				        }

				        $('#allUnreadedList').html(allUnreadedList);

			        } else {
				        alert(result.error);
			        }

			        if(self.status >= 0){
				        setTimeout(function () {self.update();}, 5000);
			        }
		        },
	        },
        });
    };

    this.save = function(){
        var self = this;

        var message = $('[data-chatid="' + self.chatId + '"]').find('input[name=chat-message]');
        var text    = message.val().trim();

        if(text.length > 0){
	        $.ajax({
		        url: self.config.save_path,
		        type: "POST",
		        dataType: "json",
		        data: {chatId: self.chatId, text: text},
		        statusCode: {
			        404: function() {
				        message.val('');

				        if(result.status == 'OK'){
					        self.update();
				        }else{
					        alert(result.error);
				        }
			        }
		        }
	        });
        }


    };
}