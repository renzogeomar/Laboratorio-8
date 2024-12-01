#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;
use CGI::Carp 'fatalsToBrowser';

# Crear un objeto CGI
my $q = CGI->new();

# Imprimir encabezados HTTP
print $q->header('text/html; charset=UTF-8');
print "<!DOCTYPE html>";
print "<html lang=\"es\">";
print "<head><title>Crear Nueva Página</title></head>";
print "<body>";

# Obtener datos del formulario
my $titulo = $q->param('titulo');     # Título de la página
my $contenido = $q->param('contenido'); # Contenido de la página

# Validar que se recibieron datos
if ($titulo && $contenido) {
    # Crear un nombre de archivo seguro
    my $filename = $titulo;
    $filename =~ s/[^a-zA-Z0-9_-]/_/g; # Reemplazar caracteres no válidos con "_"
    $filename .= ".html";
    
    # Ruta donde se guardará el archivo
    my $file_path = "/var/www/html/pages/$filename";
    
    # Crear el archivo
    open(my $fh, '>', $file_path) or die "No se pudo crear el archivo: $!";
    print $fh "<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n<title>$titulo</title>\n</head>\n<body>\n";
    print $fh "<h1>$titulo</h1>\n";
    print $fh "<div>$contenido</div>\n";
    print $fh "</body>\n</html>";
    close($fh);

    # Confirmación al usuario
    print "<h1>Página creada correctamente</h1>";
    print "<a href='list.pl'>Ver Listado de Páginas</a>";
} else {
    # Mensaje de error
    print "<h1>Error: No se recibieron todos los datos</h1>";
    print "<a href='../new.html'>Intentar de nuevo</a>";
}

print "</body></html>";