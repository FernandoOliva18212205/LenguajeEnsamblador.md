    @@
    @@ Instituto Tecnologico de Tijuana
    @@ Depto de Sistemas y Computación
    @@ Ing. En Sistemas Computacionales
    @@   
    @@ Autor : Oliver Villalobos
    @@ Repositorio: http://github.com/olivervillalobos
    @@ Fecha de elaboracion: 19/10/2020
    @@ 

.data

var1:   .byte   0b00110010
        .align
var2:   .byte   0b11000000
        .align

.text
.global main

main:   ldr     r1, = var1      /* r1 <- & var1     */
        ldrsb   r1, [ r1 ]      /* r1 <- *r1        */
        ldr     r2, = var2      /* r2 <- & var2     */
        ldrsb   r2, [ r2 ]      /* r2 <- *r2        */
        add     r0, r1, r2      /* r0 <- r1 + r2    */
        bx      lr
