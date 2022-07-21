#!/bin/bash
set -x
set -e
ln -s -f /usr/bin/python3.8 /usr/bin/python3
mkdir -p /home/${USER}
chown -R root:root /home/${USER}
PIP_CONF_FILE="/tmp/.pip/pip.conf"
mkdir -p /tmp/.pip
touch ${PIP_CONF_FILE}
echo "[global] " > ${PIP_CONF_FILE}
echo "prefix = ${JUPYTER_USR_HOME}/.local/ " >> ${PIP_CONF_FILE}
echo "index-url = ${PYPI_SERVER_URL} " >> ${PIP_CONF_FILE}
echo "${EXTRA_URL_CMD}" >> ${PIP_CONF_FILE}
echo "[install] " >> ${PIP_CONF_FILE}
echo "trusted-host = ${PYPI_SERVER_IP}${EXTRA_HOST} " >> ${PIP_CONF_FILE}
chmod -R 777 /tmp/.pip
rm -rf ${JUPYTER_USR_HOME}/.pip
rm -rf ${JUPYTER_USR_HOME}/.jupyter
bash -c "cp -rf /tmp/.pip ${JUPYTER_USR_HOME}"
rm -rf /tmp/.pip
export CAFFE_USER=${USER}
touch /tmp/ipython_config.py
echo "c.HistoryAccessor.hist_file = ':memory:'" >> /tmp/ipython_config.py
echo "c.HistoryAccessor.hist_file = ':memory:'" >> /tmp/ipython_config.py
mkdir -p ~/.ipython/profile_default
mv /tmp/ipython_config.py ~/.ipython/profile_default
export PATH=${JUPYTER_USR_HOME}/.local/bin/:${PATH}
echo "export PATH=${JUPYTER_USR_HOME}/.local/bin/:${PATH}" >> ~/.bashrc
pip install jupyterlab -i https://pypi.tuna.tsinghua.edu.cn/simple
cd ${HOME}
bash -c "export USER=${CAFFE_USER} && ${JUPTER} ${LAB} ${JUP_PORT} ${NOTEBOOK_DIR} ${JUP_ALLOW_ROOT} ${JUP_IP} ${JUP_NO_BROWSER} ${NOTEBOOK_PASSWORD} ${NOTEBOOK_TOKEN} ${NOTEBOOK_ALLOW_ORIGIN}  ${NOTEBOOK_APP_BASE_URL}  --NotebookNotary.db_file=':memory:'"
