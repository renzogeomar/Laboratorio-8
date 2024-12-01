#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use CGI::Carp 'fatalsToBrowser';

# Crear objeto CGI
my $q = CGI->new();

# Obtener el título desde los parámetros
my $titulo = $q->param('titulo');

# Ruta al archivo de datos
my $data_file = "/var/www/html/pages/pages_data.txt";

# Transformar Markdown a HTML (función básica)
sub markdown_to_html {
    my ($markdown) = @_;
    $markdown =~ s/^# (.*)/<h1>$1<\/h1>/gm;      # Títulos de nivel 1
    $markdown =~ s/^## (.*)/<h2>$1<\/h2>/gm;     # Títulos de nivel 2
    $markdown =~ s/^(?!<h)(.*)/<p>$1<\/p>/gm;    # Párrafos
    $markdown =~ s/\*\*(.*?)\*\*/<b>$1<\/b>/g;   # Negrita
    $markdown =~ s/\*(.*?)\*/<i>$1<\/i>/g;       # Cursiva
    return $markdown;
}

# Buscar el contenido asociado al título
if (-e $data_file && $titulo) {
    open my $fh, '<', $data_file or die "No se puede abrir el archivo de datos: $!";
    while (my $line = <$fh>) {
        chomp $line;
        my ($stored_title, $contenido, $ruta) = split /\|/, $line;
        if ($stored_title eq $titulo) {
            my $contenido_html = markdown_to_html($contenido);
            print $q->header('text/html; charset=UTF-8');
            print "<html lang=\"es\"><head><title>$titulo</title></head><body>";
            print "<h1>$titulo</h1>";
            print $contenido_html;
            print "<br><a href='/cgi-bin/list.pl'>Volver al listado</a>";
            print "</body></html>";
            exit;
        }
    }
    close $fh;
}

# Si no se encuentra la página, mostrar mensaje de error
print $q->header('text/html; charset=UTF-8');
print "<html lang=\"es\"><head><title>Error</title></head><body>";
print "<h1>Página no encontrada</h1>";
print "<a href='/cgi-bin/list.pl'>Volver al listado</a>";
print "</body></html>";