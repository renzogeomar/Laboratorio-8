#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp 'fatalsToBrowser';

my $q = CGI->new();
print $q->header('text/html; charset=UTF-8');
print "<html lang=\"es\"><head><title>Listado de Páginas</title></head><body>";

my $data_file = "/var/www/html/pages/pages_data.txt";

if (-e $data_file) {
    print "<h1>Listado de páginas</h1>";
    open my $fh, '<', $data_file or die "No se puede abrir el archivo de datos: $!";
    while (my $line = <$fh>) {
        chomp $line;
        my ($titulo, $contenido, $ruta) = split /\|/, $line;

        # Enlace al script view.pl con el nombre de la página como parámetro
        print "<a href='/cgi-bin/view.pl?titulo=$titulo'>$titulo</a> ";
        
        # Botones de eliminar y editar
        print "<a href='/cgi-bin/delete.pl?titulo=$titulo' style='color:red; text-decoration:none;'>[X]</a> ";
        print "<a href='/cgi-bin/edit.pl?titulo=$titulo' style='color:blue; text-decoration:none;'>[E]</a><br><br>";
    }
    close $fh;
} else {
    print "<h1>No hay páginas creadas.</h1>";
}
print "<br><form action='/new.html' method='get'>
            <button type='submit'>Regresar</button>
          </form>";
print "</body></html>";