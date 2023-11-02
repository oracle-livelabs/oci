import matplotlib.pyplot as plt
from matplotlib import patches

class OutputPlot:
    '''
    Class for the output image with bounding boxes
    '''
    def __init__(self, width, height):
        self.width = width
        self.height = height
        _, self.plot = plt.subplots()

    @classmethod
    def add_label(cls, vertex_x, vertex_y, label_name, text_color):
        '''
        Adds label to the plot
        '''
        label = plt.text(vertex_x, vertex_y, label_name, color = text_color)
        label.set_bbox(dict(facecolor='white', alpha=0.5))

    def add_bounding_boxes(self, boxes, add_labels, box_properties):
        '''
        Adds bounding box patches to the output image
        '''
        if boxes is None:
            return

        for box in boxes:
            vertices = box["bounding_polygon"]["normalized_vertices"]
            for i, _ in enumerate(vertices):
                vertices[i]['x'] *= self.width
                vertices[i]['y'] *= self.height

            vertex_x = vertices[0]['x']
            vertex_y = vertices[0]['y']
            box_width = vertices[2]['x'] - vertices[0]['x']
            box_height = vertices[2]['y'] - vertices[0]['y']
            self.plot.add_patch(patches.Rectangle(
                (vertex_x, vertex_y), box_width, box_height, fill=False,
                edgecolor=box_properties["edgecolor"], lw=box_properties["linewidth"]))
            if add_labels:
                self.add_label(vertex_x, vertex_y + box_height,
                                 box["name"], "black")