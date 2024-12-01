#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp 'fatalsToBrowser';

# Crear objeto CGI
my $q = CGI->new();
print $q->header('text/html; charset=UTF-8');
print "<html lang=\"es\"><head><title>Listado de Páginas</title></head><body>";

# Ruta al archivo de datos
my $data_file = "/var/www/html/pages/pages_data.txt";

# Verificar si el archivo de datos existe
if (-e $data_file) {
    open my $fh, '<', $data_file or die "No se puede abrir el archivo de datos: $!";
    while (my $line = <$fh>) {
        chomp $line;
        my ($titulo, $contenido, $ruta) = split /\|/, $line;

        # Mostrar el nombre de la página como un hiperenlace
        print "<p><a href='$ruta'>$titulo</a> ";

        # Botón de eliminación (X) al lado del nombre de la página
        print "<a href='/cgi-bin/delete.pl?titulo=$titulo' style='color:red; text-decoration:none;'>[X]</a> ";

        # Botón de edición (E) - Redirige a edit.pl con el nombre de la página
        print "<a href='/cgi-bin/edit.pl?titulo=$titulo' style='margin-left: 10px;'>[E]</a></p>";
    }
    close $fh;
} else {
    print "<h1>No hay páginas creadas.</h1>";
}

# Enlace para regresar a new.html
print "<br><a href='/new.html'>Regresar a crear nueva página</a>";

print "</body></html>";