import ast
import firebase_admin

from firebase_admin import credentials, firestore


# f = open('gy.txt', 'r').read()
# x = ast.literal_eval(f)
# inv_x = {v: k for k, v in x.items()}

class Manage():
    def __init__(self):
        list_items = ['hand', 'bottle', 'disk', 'snacks']
        price_dict = {'hand':100, 'bottle':50, 'disk':15, 'snacks':98}
        dics_dict = {'hand':10, 'bottle':5, 'disk':7,  'snacks':9}

        self.cred = credentials.Certificate('.//login-2-7789b-firebase-adminsdk-sbe0v-da279e5330.json')
        default_app = firebase_admin.initialize_app(self.cred)
        self.db = firestore.client()
        # self.object_doc_dict = inv_x
        # self.doc_object_dict = x
        self.list_items = list_items
        self.price_dict = price_dict
        self.dics_dict = dics_dict



    def retrieve(self):
        self.li = []
        for key in self.list_items:
            
            #print(key)
                #val = 
            doc_ref = self.db.collection(u'cart_items').document(key)
            doc = doc_ref.get()

            self.li.append(doc.to_dict())
            
            # except:
            #     pass
        return self.li
        

    def update(self, object, direction):
        self.cart_dict = self.retrieve()
        doc_ = object
        if direction == 1:
            for field in self.li:
                if field is not None:
                    if object == field['name'] :
                        
                        doc_ref = self.db.collection(u'cart_items').document(doc_)
                        doc_ref.set({
                            u'name':field['name'],
                            u'qty':field['qty'] + 1,
                            u'price':field['price'],
                            u'discount':field['discount'],
                            })
                        return

            doc_ref = self.db.collection(u'cart_items').document(doc_)
            doc_ref.set({
                u'name':doc_,
                u'qty':1,
                u'price':self.price_dict[doc_],
                u'discount':self.dics_dict[doc_]
                })

        if direction == 0:
            for field in self.li:
                if field is not None:
                    if object == field['name'] :
                        
                        doc_ref = self.db.collection(u'cart_items').document(doc_)
                        doc_ref.set({
                            u'name':field['name'],
                            u'qty':field['qty'] - 1,
                            u'price':field['price'],
                            u'discount':field['discount'],
                            })
                        return
        



        # doc_ref = db.collection(u'sampledata').document(u'inspiration')
        # doc_ref.set({
	       #  u'quote':"Hi all",
	       #  u'author':"Me"
	       #  })


# try:
#     doc = doc_ref.get()
#     print(u'document data :  {}'.format(doc.to_dict()))
# except:
#     print("datatabase retrieval failed")

#k = Manage(list_items, price_dict, dics_dict)
#print(k.retrieve())
#k.update('box', 1)
# k.update('blue_bottle')
# k.update('red_bottle')
# k.update('box_cap')
# k.update('can')
# k.update('notebook')