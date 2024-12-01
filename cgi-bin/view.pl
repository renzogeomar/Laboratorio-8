#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp 'fatalsToBrowser';
use Text::Markdown 'markdown'; # Módulo para convertir Markdown a HTML

# Crear objeto CGI
my $q = CGI->new();
print $q->header('text/html; charset=UTF-8');
print "<html lang=\"es\"><head><title>Ver Página</title></head><body>";

# Obtener el título de la página a mostrar
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
    # Convertir el contenido de Markdown a HTML
    my $contenido_html = markdown($contenido);

    # Mostrar la página en formato HTML
    print "<h1>$titulo</h1>";
    print "<div>$contenido_html</div>";
} else {
    print "<h1>Página no encontrada.</h1>";
}

# Enlace para regresar al listado
print "<br><a href='/cgi-bin/list.pl'>Regresar al listado de páginas</a>";

print "</body></html>";