import { Injectable } from '@angular/core';
import { SocketService } from './socket.service';

interface MessageInfo{
  message: string,
  messageType: number,
  chatId: number,
  currentUser: number,
  idUsuario2: number,
}

@Injectable({
  providedIn: 'root'
})
export class ChatService {
  public chatInfo: object = {};
  public chats: MessageInfo[] = [];
  constructor(private socket: SocketService) {
    this.onReceiveMessage();
    this.socket.io.on('user_connected',(id)=>{
      console.log('this id',id);
    });
  }

  sendMessage(messageInfo: MessageInfo){
    
    this.chats.push(messageInfo);
    this.socket.io.emit('sendMessage',messageInfo)
    
  }

  onReceiveMessage(){
    this.socket.io.on('receiveMessage',(messageInfo) => {
      messageInfo.messageType = 2;
      this.chats.push(messageInfo);
    });
  }
  
}
