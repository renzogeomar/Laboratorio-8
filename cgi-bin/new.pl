#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use utf8;
use CGI::Carp 'fatalsToBrowser';
use File::Basename;

# Crear un objeto CGI
my $q = CGI->new();

# Imprimir encabezados HTTP
print $q->header('text/html; charset=UTF-8');
print "<!DOCTYPE html>";
print "<html lang=\"es\">";
print "<head><title>Crear Nueva Página</title></head>";
print "<body>";

# Obtener datos del formulario
my $titulo = $q->param('titulo');       # Título de la página
my $contenido = $q->param('contenido'); # Contenido de la página

# Verificación de datos recibidos
print "<h2>Depuración: Título recibido: $titulo</h2>";
print "<h2>Depuración: Contenido recibido: $contenido</h2>";

# Validar que se recibieron todos los datos
if ($titulo && $contenido) {
    # Crear un nombre de archivo seguro
    my $filename = $titulo;
    $filename =~ s/[^a-zA-Z0-9_-]/_/g; # Reemplazar caracteres no válidos con "_"
    $filename .= ".html";
    
    # Ruta donde se guardará el archivo HTML
    my $file_path = "/var/www/html/pages/$filename";
    
    # Crear el archivo HTML con el contenido
    print "<h3>Depuración: Intentando crear archivo en: $file_path</h3>";
    open(my $fh, '>', $file_path) or die "No se pudo crear el archivo: $!";

    print $fh "<!DOCTYPE html>\n<html lang=\"es\">\n<head>\n<title>$titulo</title>\n</head>\n<body>\n";
    print $fh "<h1>$titulo</h1>\n";
    print $fh "<div>$contenido</div>\n";  # Aquí se guarda el contenido como parte del cuerpo de la página
    print $fh "</body>\n</html>";
    close($fh);
    
    # Verificación de la creación del archivo
    print "<h3>Depuración: Página HTML creada correctamente.</h3>";

    # Guardar los datos de la página en un archivo de texto
    my $data_file = '/var/www/html/pages/pages_data.txt';
    print "<h3>Depuración: Intentando guardar datos en $data_file</h3>";
    open(my $data_fh, '>>', $data_file) or die "No se pudo abrir el archivo de datos: $!";
    print $data_fh "$titulo|$contenido|$file_path\n";  # Guardamos título, contenido y ruta
    close($data_fh);

    # Confirmación al usuario
    print "<h1>Página creada correctamente</h1>";
    print "<a href='list.pl'>Ver Listado de Páginas</a>";
} else {
    # Mensaje de error
    print "<h1>Error: No se recibieron todos los datos</h1>";
    print "<a href='../new.html'>Intentar de nuevo</a>";
}

print "</body></html>";