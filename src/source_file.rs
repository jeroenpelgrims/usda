use std::fs;
use std::fs::File;
use std::path::PathBuf;

pub fn download_file(url: url::Url) -> Result<PathBuf, Box<dyn std::error::Error>> {
    let filename = url
        .path_segments()
        .and_then(|seg| seg.last())
        .expect("Couldn't figure out filename from given url");
    let output_path = PathBuf::from("downloads").join(filename);

    match output_path.try_exists()? {
        true => Ok(output_path),
        false => {
            fs::create_dir_all(&output_path.parent().unwrap())?;
            let mut response = reqwest::blocking::get(url)?;
            let mut file = File::create(&output_path)?;
            std::io::copy(&mut response, &mut file)?;
            Ok(output_path)
        }
    }
}
