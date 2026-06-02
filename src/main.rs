use std::path::PathBuf;

use clap::Parser;
use url::Url;

mod source_file;

#[derive(Parser)]
#[command(name = "usda-db")]
struct Cli {
    #[arg()]
    url: Url,

    #[arg(short, long, default_value = "downloads")]
    output_dir: PathBuf,
}

fn main() {
    let cli = Cli::parse();
    let path = source_file::download_file(cli.url);
    println!("{:?}", path);
    // unzip file
    // import into db
}
