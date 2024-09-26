# Copyright (C) 2023 Open Source Robotics Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#! [complete]
from ignition.msgs.image_pb2 import Image
from gz.transport13 import Node
import cv2
import time
import numpy as np


def stringmsg_cb(msg):
    print("Received message:")
    print(msg.height, msg.width)
    im = np.frombuffer(msg.data, dtype=np.uint8).reshape((msg.height, msg.width, 3))
    cv2.imshow("Image", im)
    cv2.waitKey(25)


def main():
    # create a transport node
    node = Node()
    topic_img = "/default/iris/iris_demo/gimbal_small_2d/tilt_link/camera/image"

    # subscribe to a topic by registering a callback
    if node.subscribe(Image, topic_img, stringmsg_cb):
        print("Subscribing to type {} on topic [{}]".format(Image, topic_img))
    else:
        print("Error subscribing to topic [{}]".format(topic_img))
        return

    # wait for shutdown
    try:
        while True:
            time.sleep(0.001)
    except KeyboardInterrupt:
        pass
    print("Done")


#! [complete]

if __name__ == "__main__":
    main()
