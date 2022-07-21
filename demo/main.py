# Time    : 2022/7/20 20:30
# Author  : cherrymonth
# Desc    : ${}
# File    : main.py
# Software: PyCharm

#!/usr/bin/env python3
# Copyright (c) Facebook, Inc. and its affiliates.

"""
PointRend Training Script.
This script is a simplified version of the training script in detectron2/tools.
"""

import cv2
import torch
from detectron2.modeling import build_model
from detectron2.checkpoint import DetectionCheckpointer
from detectron2.config import get_cfg
from detectron2.engine import default_argument_parser, default_setup
from detectron2.projects.point_rend import add_pointrend_config


def setup(args):
    """
    Create configs and perform basic setups.
    """
    cfg = get_cfg()
    cfg.MODEL.DEVICE = "cpu"
    add_pointrend_config(cfg)
    cfg.merge_from_file(args.config_file)
    cfg.merge_from_list(args.opts)
    cfg.freeze()
    default_setup(cfg, args)
    return cfg


def generate_model(args):
    cfg = setup(args)
    model = build_model(cfg)
    DetectionCheckpointer(model, save_dir=cfg.OUTPUT_DIR).resume_or_load(
        cfg.MODEL.WEIGHTS, resume=args.resume
    )
    return model


if __name__ == "__main__":
    args = default_argument_parser().parse_args()
    print("Command Line Args:", args)
    model = generate_model(args)

    image = cv2.imread('images/微信图片_20220720202948.jpg', cv2.IMREAD_COLOR)
    image = image[:,:,::-1].transpose((2,0,1))
    model.eval()

    with torch.no_grad():
        # cv2.r
        out_data = model(image)