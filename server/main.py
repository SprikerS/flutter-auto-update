from fastapi import FastAPI


app = FastAPI()


@app.get('/')
def read_root():
    return {'message': 'Welcome to the Flutter Auto Update API'}


@app.get('/update/android')
def get_app_update_info():
    latest_version = '1.0.0'
    base_url = 'https://github.com/SprikerS/flutter-auto-update/releases/download'

    tag = f'v{latest_version}'
    filename = f'flutter-auto-update-{latest_version}.apk'

    download_url = f'{base_url}/{tag}/{filename}'

    return {
        'latest_version' : latest_version,
        'download_url'   : download_url
    }