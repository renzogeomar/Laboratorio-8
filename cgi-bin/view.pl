#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp 'fatalsToBrowser';

# Crear objeto CGI
my $q = CGI->new();
print $q->header('text/html; charset=UTF-8');

# Obtener el título de la página a visualizar
my $titulo = $q->param('titulo');

# Ruta al archivo de datos
my $data_file = "/var/www/html/pages/pages_data.txt";
my $found = 0;
my ($contenido, $ruta);

# Verificar si el archivo de datos existe
if (-e $data_file) {
    open my $fh, '<', $data_file or die "No se puede abrir el archivo de datos: $!";
    
    while (my $line = <$fh>) {
        chomp $line;
        my ($titulo_file, $contenido_file, $ruta_file) = split /\|/, $line;

        # Buscar la página por su título
        if ($titulo eq $titulo_file) {
            $contenido = $contenido_file;
            $ruta = $ruta_file;
            $found = 1;
            last;
        }
    }
    close $fh;
}

if ($found) {
    # Convertir saltos de línea codificados en etiquetas <br>
    $contenido =~ s/\\n/<br>/g;

    # Mostrar la página en formato HTML
    print "<html lang=\"es\"><head><title>$titulo</title></head><body>";
    print "<h1>$titulo</h1>";
    print "<p>$contenido</p>";
    print "<br><a href='/cgi-bin/list.pl'>Regresar al listado de páginas</a>";
    print "</body></html>";
} else {
    print "<html lang=\"es\"><head><title>Página no encontrada</title></head><body>";
    print "<h1>Página no encontrada</h1>";
    print "<br><a href='/cgi-bin/list.pl'>Regresar al listado de páginas</a>";
    print "</body></html>";
}