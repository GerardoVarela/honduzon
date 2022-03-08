import { Component } from '@angular/core';
import { NgbActiveModal, NgbModal } from '@ng-bootstrap/ng-bootstrap';

import { RegisterComponent } from '../register/register.component';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styles: [`
    h2{
      color: #47525E;
    }

    .modal-header{
      border-bottom: 0px;
    }

    .modal-body{
      padding-top: 0px;
    }

    .form-floating{
      margin: 0% 15%;
    }

    .form-control{
      border-right-width: 0px;
      border-left-width: 0px;
      border-top-width: 0px;
      border-bottom-width: 1px;
      border-bottom-style: solid;
      color: #8190A5;
    }

    .form-control:focus{
      border-right-width: 0px;
      border-left-width: 0px;
      border-top-width: 0px;
      border-bottom-width: 1px;
      border-bottom-style: solid;
      border-bottom-color: #8190A5;
      outline: none;
      box-shadow: 0 0 0 0px; 
    }

    .btn-primary{ 
      background-color: #00BCE4;
      color: white;
      border: none;
      border-radius: 20px;
    }

    .btn{
      margin-top: 5%;
      margin-bottom: 10px;
      margin-left: 10%;
      margin-right: 10%;
      width: 325px;
    }

    .btn:focus{
      box-shadow: 0 0 0 0px;
      background-color: #00D0FF;
    }

    .btn:hover{
      background-color: #00D0FF;
    }

    .btn-close:focus{
      box-shadow: 0 0 0 0px;
    }

    #texto{
      font-size: 16px;
      color: #8190A5;
      text-decoration: none;
      padding-left: 10px;
      padding-right: 10px;
    }
  `]
})
export class LoginComponent {

  constructor(public activeModal: NgbActiveModal, private modalService: NgbModal) { }

  openRegister(){
    this.activeModal.close();
    this.modalService.open(RegisterComponent, {centered: true});
  }

}
