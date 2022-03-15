import { CommonModule } from '@angular/common';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from '@angular/forms';

import { LoginComponent } from './pages/login/login.component';
import { ModalComponent } from './components/modal/modal.component';
import { RegisterComponent } from './pages/register/register.component';
import { CarruselComponent } from './components/carrusel/carrusel.component';
import { CarouselModule } from 'ngx-owl-carousel-o';
import { CardCarruselComponent } from './components/card-carrusel/card-carrusel.component';

@NgModule({
  declarations: [
    LoginComponent,
    ModalComponent,
    RegisterComponent,
    CarruselComponent,
    CardCarruselComponent,
  ],
  imports: [CommonModule, ReactiveFormsModule, CarouselModule],
  exports: [
    // LoginComponent,
    // RegisterComponent,
    CarruselComponent,
  ],
  providers: [],
})
export class ProductsModule {}
