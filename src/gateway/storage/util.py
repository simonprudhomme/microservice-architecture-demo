import pika, json


def upload(f, fs, channel, access):
    try:
        print("uploading file")
        fid = fs.put(f)
    except Exception as err:
        print(err)
        return "Internal server error", 500

    print(fid)
    message = {
        "video_fid": str(fid),
        "mp3_fid": None,
        "username": access["username"],
    }

    try:
        print("publishing message")
        channel.basic_publish(
            exchange="",
            routing_key="video",
            body=json.dumps(message),
            properties=pika.BasicProperties(
                delivery_mode=pika.spec.PERSISTENT_DELIVERY_MODE
            ),
        )
    except Exception as err:
        print(err)
        fs.delete(fid)
        return err, "internal server error", 500
