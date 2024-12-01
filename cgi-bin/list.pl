#!/usr/bin/perl -w
use strict;
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

        # Mostrar la información de la página y agregar los botones de eliminar y "E"
        print "<h2>$titulo</h2>";
        print "<p>$contenido</p>";

        # Botón de eliminación (X)
        print "<a href='/cgi-bin/delete.pl?titulo=$titulo' style='color:red; text-decoration:none;'>[X]</a> ";

        # Botón de edición (E) - Sin funcionalidad por ahora
        print "<button disabled style='margin-left: 10px;'>[E]</button><br><br>";
    }
    close $fh;
} else {
    print "<h1>No hay páginas creadas.</h1>";
}
print "<br><a href='/new.html'>Regresar a crear nueva página</a>";
print "</body></html>";